require File.dirname(__FILE__) + '/helper'

class HelperTest < Test::Unit::TestCase

  include SkywriterClient::Helper

  should "define a sky_write method" do
    assert respond_to?(:sky_write)
  end

  should "define a s method" do
    assert respond_to?(:s)
  end

  should "prepend current partial when key starts with . and inside a view" do
    template = stub
    template.stubs(:path_without_format_and_extension).returns('controller/action')
    stubs(:template).returns(template)
    SkywriterClient.stubs(:sky_write)

    s(".key")

    assert_received(SkywriterClient, :sky_write) do |expect|
      expect.with("controller.action.key", nil)
    end
  end

  should "prepend controller and action when key starts with . and inside a controller" do
    stubs(:controller_name).returns("controller")
    stubs(:action_name).returns("action")
    SkywriterClient.stubs(:sky_write)

    s(".key")

    assert_received(SkywriterClient, :sky_write) do |expect|
      expect.with("controller.action.key", nil)
    end
  end

end