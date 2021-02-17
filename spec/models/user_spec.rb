require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it '全てのカラムの値が存在すれば登録できること' do
          expect(@user).to be_valid
        end
        it 'passwordが6文字以上であれば登録できること' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          expect(@user).to be_valid
        end
      end
      context '新規登録がうまくいかないとき' do
        it 'nicknameが空では登録できないこと' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
        it 'emailが空では登録できないこと' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it 'passwordが空では登録できないこと' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it 'last_nameが空では登録できないこと' do
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank")
        end
        it 'first_nameが空では登録できないこと' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end

        it 'last_name_kanaが空では登録できないこと' do
          @user.last_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana can't be blank")
        end
        it 'first_name_kanaが空では登録できないこと' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana can't be blank")
        end
        it 'birthdayが空では登録できないこと' do
          @user.birthday = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end
        it 'emailが一意性であること' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end
        it 'emailが@を含む必要があること' do
          @user.email = 'test'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end
        it 'passwordが5文字以下であれば登録できないこと' do
          @user.password = '12345'
          @user.password_confirmation = '12345'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end
        it 'passwordとpassword_confirmationが不一致では登録できないこと' do
          @user.password = '123456'
          @user.password_confirmation = '1234567'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it 'last_nameが全角（漢字・ひらがな・カタカナ）ではないと登録できないこと' do
          @user.last_name = 'test'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name 全角文字を使用してください')
        end
        it 'first_nameが全角（漢字・ひらがな・カタカナ）ではないと登録できないこと' do
          @user.first_name = 'test'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
        end
        it 'last_name_kanaが全角（カタカナ）ではないと登録できないこと' do
          @user.last_name_kana = 'ひらがな'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
        end
        it 'first_name_kanaが全角（カタカナ）ではないと登録できないこと' do
          @user.first_name_kana = 'ひらがな'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
        end
      end
    end
  end
end
