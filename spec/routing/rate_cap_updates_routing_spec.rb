require "rails_helper"

RSpec.describe RateCapUpdatesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/rate_cap_updates").to route_to("rate_cap_updates#index")
    end

    it "routes to #new" do
      expect(get: "/rate_cap_updates/new").to route_to("rate_cap_updates#new")
    end

    it "routes to #show" do
      expect(get: "/rate_cap_updates/1").to route_to("rate_cap_updates#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/rate_cap_updates/1/edit").to route_to("rate_cap_updates#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/rate_cap_updates").to route_to("rate_cap_updates#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/rate_cap_updates/1").to route_to("rate_cap_updates#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/rate_cap_updates/1").to route_to("rate_cap_updates#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/rate_cap_updates/1").to route_to("rate_cap_updates#destroy", id: "1")
    end
  end
end
