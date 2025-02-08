require 'rails_helper'

RSpec.describe "Recommend", type: :system do
  let(:user) { create(:user) }
  let(:recommend) { create(:recommend) }

  describe "ログイン前" do
    describe "ページ遷移確認" do
      context "マストアイテムの新規登録ページにアクセス" do
        it "新規登録ページへのアクセスが失敗する" do
          visit new_recommend_path
          expect(page).to have_content("ログインが必要です")
          expect(current_path).to eq new_user_session_path
        end
      end

      context "マストアイテムの編集ページにアクセス" do
        it "編集ページへのアクセスが失敗する" do
          visit edit_recommend_path(recommend)
          expect(page).to have_content("ログインが必要です")
          expect(current_path).to eq new_user_session_path
        end
      end

      context "マストアイテムの詳細ページにアクセス" do
        it "マストアイテムの詳細情報が表示される" do
          visit recommend_path(recommend)
          expect(page).to have_content recommend.item
          expect(current_path).to eq recommend_path(recommend)
        end
      end

      context "場所ごとのマストアイテムの一覧ページにアクセス" do
        it "場所ごとのマストアイテムの一覧情報が表示される" do
          visit by_place_recommends_path(recommend)
          expect(page).to have_content :item
          expect(current_path).to eq by_place_recommends_path(recommend)
        end
      end

      context "マストアイテムの一覧ページにアクセス" do
        it "すべてのユーザーのマストアイテムが表示される" do
          recommend_list = create_list(:recommend, 3)
          visit recommends_path
          expect(page).to have_content recommend_list[0].place
          expect(page).to have_content recommend_list[1].place
          expect(page).to have_content recommend_list[2].place
          expect(current_path).to eq recommends_path
        end
      end
    end
  end

  describe "ログイン後" do
    before { login_as(user) }

    describe "マストアイテム新規登録" do
      context "フォームの入力値が正常" do
        it "マストアイテムの新規作成が成功する" do
          visit new_recommend_path
          fill_in "recommend[place]", with: "place"
          fill_in "recommend[item]", with: "item"
          fill_in "recommend[body]", with: "body"
          click_button "投稿を作成"
          expect(page).to have_content "place"
          expect(page).to have_content "item"
          expect(page).to have_content "body"
          expect(current_path).to start_with("/recommends")
        end
      end

      context "場所が未入力" do
        it "マストアイテムの新規作成が失敗する" do
          visit new_recommend_path
          fill_in "recommend[place]", with: ""
          fill_in "recommend[item]", with: "item"
          fill_in "recommend[body]", with: "body"
          click_button "投稿を作成"
          expect(page).to have_content "マストアイテムを登録できませんでした"
          expect(page).to have_content "持って行く場所を入力してください"
          expect(current_path).to start_with("/recommends")
        end
      end

      context "アイテムが未入力" do
        it "マストアイテムの新規作成が失敗する" do
          visit new_recommend_path
          fill_in "recommend[place]", with: "place"
          fill_in "recommend[item]", with: ""
          fill_in "recommend[body]", with: "body"
          click_button "投稿を作成"
          expect(page).to have_content "マストアイテムを登録できませんでした"
          expect(page).to have_content "持って行くものを入力してください"
          expect(current_path).to start_with("/recommends")
        end
      end
    end

    describe "マストアイテム編集" do
      let!(:recommend) { create(:recommend, user: user) }
      let(:other_recommend) { create(:recommend, user: user) }
      before { visit edit_recommend_path(recommend) }

      context "フォームの入力値が正常" do
        it "マストアイテムの編集が成功する" do
          fill_in "recommend[place]", with: "update_place"
          fill_in "recommend[item]", with: "update_item"
          fill_in "recommend[body]", with: "update_body"
          click_button "投稿を保存"
          expect(page).to have_content "マストアイテムを更新しました"
          expect(current_path).to start_with("/recommends")
        end
      end

      context "場所が未入力" do
        it "マストアイテムの編集が失敗する" do
          fill_in "recommend[place]", with: nil
          click_button "投稿を保存"
          expect(page).to have_content "マストアイテムを更新できませんでした"
          expect(page).to have_content "持って行く場所を入力してください"
          expect(current_path).to start_with("/recommends")
        end
      end

      context "アイテムが未入力" do
        it "マストアイテムの編集が失敗する" do
          fill_in "recommend[item]", with: nil
          click_button "投稿を保存"
          expect(page).to have_content "マストアイテムを更新できませんでした"
          expect(page).to have_content "持って行くものを入力してください"
          expect(current_path).to start_with("/recommends")
        end
      end
    end

    describe "マストアイテム削除" do
      let!(:recommend) { create(:recommend, user: user) }

      it "マストアイテムの削除が成功する" do
        visit edit_recommend_path(recommend)
        click_link "投稿を削除"
        expect(page.accept_confirm).to eq "削除しますか？"
        expect(page).to have_content "マストアイテムを削除しました"
        expect(current_path).to eq recommends_path
        expect(page).not_to have_content recommend.item
      end
    end
  end
end
