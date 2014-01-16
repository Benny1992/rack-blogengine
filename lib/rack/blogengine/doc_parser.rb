module Rack
  module Blogengine
    # 
    # Prepares the documents for the response
    # Reads in layout.html and .content file -> merged html
    # Sort documents by date
    # Execute Content Operator after all documents has been parsed in
    # 
    # @author [benny]
    # 
    class DocParser
      # Parse in .content Documents.
      # @param target.
      # @return [Hash] Documents 
      def self.parseInDocuments(target)
        @target = target
        documents = []

        layout_file = ::File.open("#{@target}/assets/layout/layout.html", "r")
        @layout = layout_file.read

        Dir.foreach("#{target}/") do |item|
          extension = item.split(".")[1]
          next if item == '.' or item == '..' or extension != "content"
  					
          getFileContents(item)
          @html = fillFileContents(@layout)
  					
          @document = Document.new
          @document.path = @path
          @document.html = @html
          @document.title = @title
          @document.date = @date

          documents << @document
        end

        sort documents

        # Has to exec operator after all docs were read, so documents are available for operators (list all docs, etc...)
        documents.each do |document|
          document.exec_content_operator(documents, @target)
        end

        documentshashed = documents.map do |document|
          document.to_hash
        end

        return documentshashed
      end

      # Get File Contents (path, title, content)
      # @param [String] file
      def self.getFileContents(file)
        content_file = ::File.open("#{@target}/#{file}");
        content = content_file.read

        # Replace Closing tags
        content["/path"] = "/close"
        content["/title"] = "/close"
        content["/content"] = "/close"
        content["/date"] = "/close"
  
        contentarray = content.split("[/close]")

        contentarray.each do |contentblock|
          if contentblock.include? "[path]:"
            contentblock["[path]:"] = ""
            @path = "/#{contentblock}"
          end

          if contentblock.include? "[title]:"
            contentblock["[title]:"] = ""
            @title = contentblock.strip
          end

          if contentblock.include? "[content]:"
            contentblock["[content]:"] = ""
            @content = contentblock.strip
          end

          if contentblock.include? "[date]:"
            contentblock["[date]:"] = ""
            datearray = contentblock.split(",")
            datearray = datearray.map do |date|
              date = date.to_i
            end

            @date = Date.new(datearray[0], datearray[1], datearray[2])
          end
        end
      end

      # Replace layout placeholder with content from .content file
      # @param [String] layout
      # return [String] html placeholder replaced with content
      def self.fillFileContents(layout)
        html = layout.dup

        html.gsub! "{title}", @title
        html["{content}"] = @content
        html.gsub! "{date}", @date.strftime('%d.%m.%Y')

        return html
      end

      # Sort documents array by date of each documenthash
      # @param [Array] documents
      # return [Array] documents (sorted)
      # Should it be sorted in Core or in the operator??
      def self.sort(documents)
        documents.sort! do | a, b |
          a.date.to_time.to_i <=> b.date.to_time.to_i
        end

        return documents
      end
    end
  end
end