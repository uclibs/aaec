# spec/routes/admin_routes_spec.rb

require "rails_helper"

RSpec.describe "Admin Routes", type: :routing do
  describe "GET #citations" do
    it "routes to admin#citations" do
      expect(get: "/citations").to route_to("admin#citations")
    end
  end

  describe "GET #toggle_links" do
    it "routes to admin#toggle_links" do
      expect(get: "/toggle_links").to route_to("admin#toggle_links")
    end
  end

  describe "GET #manage" do
    it "routes to admin#login" do
      expect(get: "/manage").to route_to("admin#login")
    end
  end

  describe "POST #manage/validate" do
    it "routes to admin#validate" do
      expect(post: "/manage/validate").to route_to("admin#validate")
    end
  end

  describe "GET #csv/:controller_name" do
    it "routes to admin#csv" do
      expect(get: "/csv/example_controller").to route_to("admin#csv", controller_name: "example_controller")
    end
  end
end
