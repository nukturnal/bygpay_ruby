require "spec_helper"

RSpec.describe Bygpay::Deposits do
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

      it 'should return true when transaction_status method is called' do
        expect(@mobile_deposit.transaction_status(@mobile_deposit.uuid)).to eql true
      end

      it 'should return valid transaction status flag' do
        expect(%w(accepted pending fail success)).to include(@mobile_deposit.status)
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

      it 'Bygpay::BygResponse methods should return expected results' do
        @mobile_deposit.charge(@deposit_amount, @valid_mobile_payload)

        expect([true, false]).to include(@mobile_deposit.response.success?)
        expect([true, false]).to include(@mobile_deposit.response.failed?)
        expect([true, false]).to include(@mobile_deposit.response.pending?)
        expect(@mobile_deposit.response.processor_transaction_id).to be_nil
        expect(@mobile_deposit.response.currency).not_to be_empty
        expect(@mobile_deposit.amount).to be > 0
        expect(@mobile_deposit.response.provider).not_to be_empty
      end
    end

    context 'Rave Redirect' do
      it 'should return true we call the charge method' do
        response = @rave_redirect.charge(@deposit_amount, @valid_rave_payload)
        expect(response).to eql true
      end

      it 'should not have an empty transaction_id when charge method returns true' do
        # This relies directly on the above spec (for speed)
        # Change this with caution
        expect(@rave_redirect.transaction_id).not_to be_empty
      end

      it 'should return true when transaction_status method is called' do
        expect(@rave_redirect.transaction_status(@rave_redirect.uuid)).to eql true
      end

      it 'should return valid transaction status flag' do
        expect(%w(accepted pending fail success)).to include(@rave_redirect.status)
      end

      it 'should return true when valid currency is included in payload' do
        response = @rave_redirect.charge(@deposit_amount, @valid_rave_payload.merge(@valid_currency))
        expect(response).to eql true
      end

      it 'should return false when invalid currency is included in payload' do
        response = @rave_redirect.charge(@deposit_amount, @valid_rave_payload.merge(@invalid_currency))
        expect(response).to eql false
      end

      it 'response_text should not be empty on validation error for charge method call' do
        expect(@rave_redirect.response_text).not_to be_empty
      end

      it 'status after charge method validation error should return fail' do
        expect(@rave_redirect.status).to eql 'fail'
      end

      it 'response variable of the deposit object should be an instance of Bygpay::BygResponse' do
        expect(@rave_redirect.response).to be_instance_of Bygpay::BygResponse
      end

      it 'Bygpay::BygResponse methods should return expected results' do
        @rave_redirect.charge(@deposit_amount, @valid_rave_payload)

        expect([true, false]).to include(@rave_redirect.response.success?)
        expect([true, false]).to include(@rave_redirect.response.failed?)
        expect([true, false]).to include(@rave_redirect.response.pending?)
        expect(@rave_redirect.response.processor_transaction_id).to be_nil
        expect(@rave_redirect.response.redirect_link).not_to be_empty
        expect(@rave_redirect.response.currency).not_to be_empty
        expect(@rave_redirect.amount).to be > 0
      end
    end

    context 'Debit/Credit Cards' do
      it 'should return false we call the charge method on valid test card' do
        response = @card_deposit.charge(@deposit_amount, @valid_card_payload)
        expect(response).to eql false
      end

      it 'should not have an empty transaction_id when charge method returns true' do
        expect(@card_deposit.transaction_id).not_to be_empty
      end

      it 'should return true when valid currency is included in payload' do
        response = @card_deposit.charge(@deposit_amount, @valid_card_payload.merge(@valid_currency))
        expect(response).to eql false
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
end
