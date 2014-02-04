require 'docker'

describe "threescale proxy image" do
    before(:all) {
        @image = Docker::Image.all().detect{|i| i.info['Repository'] == 'rhoml/docker-3scale-proxy'}
    }

    it "should be availble" do
        expect(@image).to_not be_nil
    end
end
