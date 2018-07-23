require "spec_helper"

RSpec.describe Bygpay::Withdrawals do
  describe 'Withdrawal Transactions' do
    context 'Mobile Money' do
      it 'should return true we call the charge method' do
        response = @mobile_withdraw.sendmoney(@withdraw_amount, @valid_mobile_payload)
        expect(response).to eql true
      end

      it 'should not have an empty transaction_id when charge method returns true' do
        # This relies directly on the above spec (for speed)
        # Change this with caution
        expect(@mobile_withdraw.transaction_id).not_to be_empty
      end

      it 'should return true when transaction_status method is called' do
        expect(@mobile_withdraw.transaction_status(@mobile_withdraw.uuid)).to eql true
      end

      it 'should return valid transaction status flag' do
        expect(%w(accepted pending fail success)).to include(@mobile_withdraw.status)
      end

      it 'should return false on validation error for charge method call' do
        response = @mobile_withdraw.sendmoney(@withdraw_amount, @invalid_mobile_payload)
        expect(response).to eql false
      end

      it 'response_text should not be empty on validation error for charge method call' do
        expect(@mobile_withdraw.response_text).not_to be_empty
      end

      it 'status after charge method validation error should return fail' do
        expect(@mobile_withdraw.status).to eql 'fail'
      end

      it 'response variable of the deposit object should be an instance of Bygpay::BygResponse' do
        expect(@mobile_withdraw.response).to be_instance_of Bygpay::BygResponse
      end
    end
  end
end
