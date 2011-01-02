require 'spec_helper'

module FlashInterceptor

  describe FlashHashWithCallbacks do

    before do
      @mock_controller  = mock('ActionController::Base')
      @mock_flash       = mock('FlashHash') 
    end

    describe ".new" do

      it "creates a new instance of FlashHashWithLogger" do
        FlashHashWithCallbacks.new(@mock_controller, @mock_flash).should_not be_nil
      end

    end

    context "with a new instance" do

      let(:flash) { FlashHashWithCallbacks.new(@mock_controller, @mock_flash) }

      describe "#[]" do

        it "delegates to the flash objects [] method" do
          k, v = "key", "value"
          @mock_flash.expects(:[]).with(k)
          flash[k]
        end

      end

      describe "#[]=" do

        it "delegates to the flash objects []= method" do
          k, v = "key", "value"
          @mock_flash.expects(:[]=).with(k, v)
          flash[k] = v
        end

        it "logs the message using a loggable key" do
          k, v = :notice, "value"
          @mock_flash.expects(:[]=).with(k, v)
          @mock_controller.expects(:log).with(v)
          flash[k] = v
        end

        it "does not log the message using a non loggable key" do
          k, v = :bad_key, "value"
          @mock_flash.expects(:[]=).with(k, v)
          @mock_controller.expects(:log).never.with(v)
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
