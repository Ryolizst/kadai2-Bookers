class BooksController < ApplicationController

 def top
    # トップページに必要なコードがあれば追加
  end

#bookの新規登録機能作成
def new
  @book = Book.new
end

# 以下を追加
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
   if @book.save
    # 4. 詳細ページへリダイレクト
     flash[:notice] = "Book was successfully created."
     redirect_to book_path(@book)
  else
    # 保存に失敗した場合は、再度ページを表示
    flash[:alert] = "error: Could not save the book."
    @books = Book.all               # 保存失敗時にも一覧表示
    render :index                 # 再度indexページを表示
   end
  end

 # 一覧表示と新規投稿フォームを同じページに表示
def index
  @books = Book.order(created_at: :asc) # 古い投稿が上に表示
  @book = Book.new
end

  def show
    @book = Book.find(params[:id])
  end

  def edit
     @book = Book.find(params[:id])
  end



def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book)
  else
  flash[:alert] = "error: Could not update the book."
  render :edit
  end
end

 def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: ' Book was successfully destroyed.'
end

private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end