require "capybara/rspec"
require "capybara/apparition"

Capybara.register_driver :apparition do |app|
  Capybara::Apparition::Driver.new app,
    headless: true,
    debug: true,
    browser_options: {
      "no-sandbox" => true,
      "disable-dev-shm-usage" => true
    }
end

Capybara.default_driver = :apparition
Capybara.javascript_driver = :apparition
