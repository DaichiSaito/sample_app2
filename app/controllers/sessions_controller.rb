class SessionsController < ApplicationController
  # def new
  # 	@user = User.new
  # end

  # def create
  # 	@user = User.new(user_params)
  # 	# debugger
  # 	if @user.save
  # 		flash[:success] = "Welcome to the Sample App!"
  # 		redirect_to @user
  # 	else
  # 		render 'new'
  # 	end
  # end
  def new
  end

  def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      # flash[:success] = "Welcome to the Sample App!"
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # remember user #コントローラのrememberではなくhelperのremember
      redirect_to user
    else
      #エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination' # 本当は正しくない
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
