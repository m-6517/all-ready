require 'rails_helper'

RSpec.describe "Users", type: :system do
  include LoginMacros

  let(:user) { create(:user) }

  describe "ログイン前" do
    describe "ユーザー新規登録" do
      context "フォームの入力値が正常" do
        it "ユーザーの新規作成が成功する" do
          visit new_user_registration_path

          fill_in "password_field", with: "password"
          fill_in "password_confirmation_field", with: "password"
          page.execute_script("document.getElementById('show_password').click()")
          page.execute_script("document.getElementById('show_password_confirmation').click()")

          click_button "アカウントを作成"
          expect(page).to have_content "マストアイテム"
        end
      end

      context "アカウント名が未入力" do
        it "ユーザーの新規作成が失敗する" do
          visit new_user_registration_path

          fill_in "アカウント名", with: ""
          fill_in "メールアドレス", with: "email@example.com"

          fill_in "password_field", with: "password"
          fill_in "password_confirmation_field", with: "password"
          page.execute_script("document.getElementById('show_password').click()")
          page.execute_script("document.getElementById('show_password_confirmation').click()")

          click_button "アカウントを作成"
          expect(page).to have_content("ユーザー は保存されませんでした")
          expect(page).to have_content "アカウント名を入力してください"
          expect(current_path).to eq new_user_registration_path
        end
      end

      context "メールアドレスが未入力" do
        it "ユーザーの新規作成が失敗する" do
          visit new_user_registration_path

          fill_in "password_field", with: "password"
          fill_in "password_confirmation_field", with: "password"
          page.execute_script("document.getElementById('show_password').click()")
          page.execute_script("document.getElementById('show_password_confirmation').click()")

          click_button "アカウントを作成"
          expect(page).to have_content("ユーザー は保存されませんでした")
          expect(page).to have_content "メールアドレスを入力してください"
          expect(current_path).to eq new_user_registration_path
        end
      end
    end

    describe "マイページ" do
      context "ログインしていない状態" do
        it "マイページへのアクセスが失敗する" do
          visit profile_path(user)
          expect(page).to have_content("ログインが必要です")
          expect(current_path).to start_with("/profile")
        end
      end
    end
  end

  describe "ログイン後" do
    before { login_as(user) }

    describe "ユーザー編集" do
      context "フォームの入力値が正常" do
        it "ユーザーの編集が成功する" do
          visit edit_profile_path(user)
          fill_in "アカウント名", with: "sample.name"
          fill_in "メールアドレス", with: "update@example.com"
          click_button "プロフィールを保存"
          expect(page).to have_content("ユーザーを更新しました")
          expect(current_path).to start_with("/profile")
        end
      end

      context "アカウント名が未入力" do
        it "ユーザーの編集が失敗する" do
          visit edit_profile_path(user)
          fill_in "アカウント名", with: ""
          fill_in "メールアドレス", with: "update@example.com"
          click_button "プロフィールを保存"
          expect(page).to have_content("ユーザーを更新できませんでした")
          expect(page).to have_content("アカウント名を入力してください")
          expect(current_path).to start_with("/profile")
        end
      end

      context "メールアドレスが未入力" do
        it "ユーザーの編集が失敗する" do
          visit edit_profile_path(user)
          fill_in "メールアドレス", with: ""
          click_button "プロフィールを保存"
          expect(page).to have_content("ユーザーを更新できませんでした")
          expect(page).to have_content("メールアドレスを入力してください")
          expect(current_path).to start_with("/profile")
        end
      end
    end
  end
end
