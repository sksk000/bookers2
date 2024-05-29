class BooksController < ApplicationController

    def new
        @book = Book.new
    end

    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id

        if @book.save
            flash[:notice] = "You have created book successfully.."
            redirect_to books_path
        else
            flash[:error] = @book.errors.full_messages
            redirect_to request.path
        end
    end

    def index
        @book = Book.all
        @user = current_user;
    end

    def show
        @book = Book.find(params[:id])
        @user = @book.user
    end

    def edit
        @book = Book.find(params[:id])
        unless current_user.id == @book.user_id
            redirect_to request.fullpath
        end

    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to book_path(@book.id)
        else
            flash[:book_edit_error] = @book.errors.full_messages
            render "edit"
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end

    private

    def book_params
        params.require(:book).permit(:title, :body, :user_id)
    end
end
