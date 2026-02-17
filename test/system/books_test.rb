# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
    @user = users(:one)
    login @user
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  test 'should create book' do
    visit books_url
    click_on '本の新規作成'
    fill_in 'タイトル', with: '新しい本のタイトル'
    fill_in 'メモ', with: '新しい本のメモ'
    click_on '登録する'
    assert_text '本が作成されました。'
    assert_text '新しい本のタイトル'
  end

  test 'should update Book' do
    visit book_url(@book)
    click_on 'この本を編集', match: :first
    fill_in 'タイトル', with: '更新されたタイトル'
    click_on '更新する'
    assert_text '本が更新されました。'
    assert_text '更新されたタイトル'
  end

  test 'should destroy Book' do
    visit book_url(@book)
    click_on 'この本を削除', match: :first
    assert_text '本が削除されました。'
  end
end
