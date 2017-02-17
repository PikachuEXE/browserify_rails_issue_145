module LandingPage::Show
  class ActionController < ApplicationController
    def call
      render(
        template: "templates/landing_page/show/page",
        layout:   "application",
      )
    end
  end
end
