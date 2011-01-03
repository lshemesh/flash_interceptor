require 'spec_helper'

module FlashInterceptor

  describe FlashHashWithCallbacks do

    before do
      @controller  = TestController.new
      @mock_flash  = DummyFlash.new
      TestController.clear_flash_callbacks
    end

    describe ".new" do

      it "creates a new instance of FlashHashWithLogger" do
        FlashHashWithCallbacks.new(@controller, @mock_flash).should_not be_nil
      end

    end

    context "with a new instance" do

      let(:flash) { FlashHashWithCallbacks.new(@controller, @mock_flash) }

      describe "#[]" do

        it "delegates to the flash objects [] method" do
          k = "key1"
          flash[k].should == "value1"
        end

      end

      describe "#[]=" do

        it "delegates to the flash objects []= method" do
          k, v = "new_key", "new_value"
          flash[k] = v
          @mock_flash[k].should == v
        end

        it "calls the callbacks" do
          k, v = :notice, "value"
          @controller.expects(:perform_before_flash_callbacks)
          flash[k] = v
        end

      end

      describe "#now" do
        it "sets the flash object to a FlashNow object" do
          @mock_flash.expects(:now).returns(mock_flash_now = mock('FlashNow'))
          flash.expects(:flash=).with(mock_flash_now)
          flash.now
        end
      end

      describe "#each" do
        it "delegates to the FlashHash each method" do
          block = Proc.new {}
          @mock_flash.expects(:each)
          flash.each
        end
      end

    end

  end

end
