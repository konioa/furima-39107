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
        expect(@order_payment.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postcodeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_payment.postcode = '1234567'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('郵便番号はハイフン(-)を含めてください')
      end
      it 'prefectureを選択していないと保存できないこと' do
        @order_payment.prefecture_id = 1
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it 'cityが空だと保存できないこと' do
        @order_payment.city = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'blockが空だと保存できないこと' do
        @order_payment.block = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("番地を入力してください")
      end
      it 'phoneが空だと保存できないこと' do
        @order_payment.phone = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phoneが9桁以下は保存できない' do
        @order_payment.phone = '080000000'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'phoneが12桁以下は保存できない' do
        @order_payment.phone = '080000000000'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'phoneが半角数字以外は保存できない' do
        @order_payment.phone = '００００００００００'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'userが紐付いていないと保存できないこと' do
        @order_payment.user_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("ユーザーを入力してください")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_payment.item_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("アイテムを入力してください")
      end

      it "tokenが空では登録できないこと" do
        @order_payment.token = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
