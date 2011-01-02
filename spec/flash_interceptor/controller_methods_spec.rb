require 'spec_helper'

module FlashInterceptor

  describe ControllerMethods do

    before do
      @controller = TestController.new
      @controller.stubs(:flash_without_callbacks).returns(DummyFlash.new)
      TestController.clear_flash_callbacks
    end

    it "has a before_flash method" do
      TestController.should respond_to :before_flash
    end

    it "adds :some_callback to before_callbacks" do
      TestController.before_flash :some_callback
      TestController.before_flash_callbacks.should include(:some_callback)
    end

    it "adds multiple callbacks" do
      TestController.before_flash :callback1, :callback2
      TestController.before_flash_callbacks.should include(:callback1, :callback2)
    end

    it "calls the callbacks" do
      TestController.before_flash :callback1
      @controller.expects(:callback1)
      @controller.flash["key"] = "message"
    end

  end

end
