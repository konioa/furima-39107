require 'rails_helper'

RSpec.describe OrderPayment, type: :model do
  describe '商品購入の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_payment = FactoryBot.build(:order_payment, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_payment).to be_valid
      end
      it 'building空でも保存できること' do
        @order_payment.building = ''
        expect(@order_payment).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postcodeが空だと保存できないこと' do
        @order_payment.postcode = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Postcode can't be blank")
      end
      it 'postcodeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_payment.postcode = '1234567'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it 'prefectureを選択していないと保存できないこと' do
        @order_payment.prefecture_id = 1
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @order_payment.city = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("City can't be blank")
      end
      it 'blockが空だと保存できないこと' do
        @order_payment.block = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Block can't be blank")
      end
      it 'phoneが空だと保存できないこと' do
        @order_payment.phone = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Phone can't be blank")
      end
      it 'phoneが10桁以上11桁以下でないと保存できない' do
        @order_payment.phone = '080000000000'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Phone is invalid')
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_payment.user_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_payment.item_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Item can't be blank")
      end

      it "tokenが空では登録できないこと" do
        @order_payment.token = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
