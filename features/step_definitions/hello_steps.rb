Given(/^I am on the home page$/) do
  puts  visit 'http://localhost:3000'
end

Then(/^I should see "(.*?)"$/) do |text|
  page.has_content?(text)
  # page.driver.resize(20,30)
  # page.save_screenshot("/path/to/test.pdf")
  # puts page.within_window
  # puts page.driver.network_traffic
  # puts page.driver.cookies
  # puts page.response_headers.to_a
end
