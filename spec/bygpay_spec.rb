require "spec_helper"

RSpec.describe Bygpay do
  it "has a version number" do
    expect(Bygpay::VERSION).not_to be nil
  end

  describe 'Deposit Transactions' do
    context 'Mobile Money' do
      it 'should return true we call the charge method' do
        response = @mobile_deposit.charge(@deposit_amount, @valid_mobile_payload)
        expect(response).to eql true
      end

      it 'should not have an empty transaction_id when charge method returns true' do
        # This relies directly on the above spec (for speed)
        # Change this with caution
        expect(@mobile_deposit.transaction_id).not_to be_empty
      end

      it 'should return true when valid currency is included in payload' do
        response = @mobile_deposit.charge(@deposit_amount, @valid_mobile_payload.merge(@valid_currency))
        expect(response).to eql true
      end

      it 'should return false when invalid currency is included in payload' do
        response = @mobile_deposit.charge(@deposit_amount, @valid_mobile_payload.merge(@invalid_currency))
        expect(response).to eql false
      end

      it 'should return false on validation error for charge method call' do
        response = @mobile_deposit.charge(@deposit_amount, @invalid_mobile_payload)
        expect(response).to eql false
      end

      it 'response_text should not be empty on validation error for charge method call' do
        expect(@mobile_deposit.response_text).not_to be_empty
      end

      it 'status after charge method validation error should return fail' do
        expect(@mobile_deposit.status).to eql 'fail'
      end

      it 'response variable of the deposit object should be an instance of Bygpay::BygResponse' do
        expect(@mobile_deposit.response).to be_instance_of Bygpay::BygResponse
      end
    end

    context 'Debit/Credit Cards' do
      it 'should return true we call the charge method' do
        response = @card_deposit.charge(@deposit_amount, @valid_card_payload)
        expect(response).to eql true
      end

      it 'should not have an empty transaction_id when charge method returns true' do
        # This relies directly on the above spec (for speed)
        # Change this with caution
        expect(@card_deposit.transaction_id).not_to be_empty
      end

      it 'should return true when valid currency is included in payload' do
        response = @card_deposit.charge(@deposit_amount, @valid_card_payload.merge(@valid_currency))
        expect(response).to eql true
      end

      it 'should return false when invalid currency is included in payload' do
        response = @card_deposit.charge(@deposit_amount, @valid_card_payload.merge(@invalid_currency))
        expect(response).to eql false
      end

      it 'should return false on validation error for charge method call' do
        response = @card_deposit.charge(@deposit_amount, @invalid_card_payload)
        expect(response).to eql false
      end

      it 'response_text should not be empty on validation error for charge method call' do
        expect(@card_deposit.response_text).not_to be_empty
      end

      it 'status after charge method validation error should return fail' do
        expect(@card_deposit.status).to eql 'fail'
      end

      it 'response variable of the deposit object should be an instance of Bygpay::BygResponse' do
        expect(@card_deposit.response).to be_instance_of Bygpay::BygResponse
      end
    end
  end

  describe 'Withdrawal Transactions' do
    context 'Mobile Money' do
      it 'should return true we call the charge method' do
        response = @mobile_withdraw.send(@withdraw_amount, @valid_mobile_payload)
        expect(response).to eql true
      end

      it 'should not have an empty transaction_id when charge method returns true' do
        # This relies directly on the above spec (for speed)
        # Change this with caution
        expect(@mobile_withdraw.transaction_id).not_to be_empty
      end

      it 'should return false on validation error for charge method call' do
        response = @mobile_withdraw.send(@withdraw_amount, @invalid_mobile_payload)
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
