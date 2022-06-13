class MessagesController < ApplicationController
    before_action :find_conversation
  
    def index
      @users = User.all
      @conversations = Conversation.all
      if current_user == @conversation.sender || current_user == @conversation.recipient
    
        @messages = @conversation.messages
  
        if @messages.length > 10
          @over_ten = true
          @messages = @messages[-10..-1]
        end
    
        if params[:m]
          @over_ten = false
          @messages = @conversation.messages
        end
    
        @message = @conversation.messages.new
  
      else
        redirect_to conversations_path
      end
  
    end
  
    def create
      @message = @conversation.messages.new(message_params)
      if @message.save
        redirect_to conversation_messages_path(@conversation)
      end
    end
  
    def new
      @message = @conversation.messages.new
    end
  
  
  
    private
  
      def message_params
        params.require(:message).permit(:body, :user_id)
      end
  
      def find_conversation
        @conversation = Conversation.find(params[:conversation_id])
      end
end
  