class StudentsController < ApplicationController
  def index
    @pw = params[:password]
    @em = params[:email]
    flash[:notice] = ""
    if @pw == nil || @pw == "" || @em == nil || @em == ""
      defaultInfo
    else
      tempStudent = Student.where(password: @pw, email: @em)
      if tempStudent.exists?
        @introMsg = tempStudent.pluck(:firstName)[0] + " " + tempStudent.pluck(:lastName)[0]
      else
        defaultInfo
        flash[:notice] = "Sorry, Incorrect Login"
      end
    end
  end
  
  def search
    @pw = params[:password]
    @em = params[:email]
    if @pw == nil || @pw == "" || @em == nil || @em == ""
      defaultInfo
    else
      tempStudent = Student.where(password: @pw, email: @em)
      @introMsg = tempStudent.pluck(:firstName)[0] + " " + tempStudent.pluck(:lastName)[0]
    end
  end
  
  def defaultInfo
    params[:password] = ""
    params[:email] = ""
    @pw = params[:password]
    @em = params[:email]
    @introMsg = "Guest"
  end
  
  def new
  end
  
  def create
    @p = params[:student]
    @student = Student.create!([{firstName: @p[:firstName], lastName: @p[:lastName], classYear: 0000, advisor: "", intro: "", research: [], colleagues: [], careers: [], profilePic: "", password: @p[:password], email: @p[:email]}])
    flash[:notice] = "New User Created.  Now log in."
    redirect_to students_index_url
  end
  
  def profile
    @pw = params[:password]
    @em = params[:email]
    @student = Student.find(1)
    @studName = @student.firstName + " " + @student.lastName
    
    if(Student.where(password: @pw, email: @em) == @student)
      @studName = @studName + " (You)"
    end
  end
  
  def message
    @pw = params[:password]
    @em = params[:email]
  end 
  
  def searchBox
    @fn = params[:first_name]
    @ln = params[:last_name]
    @adv = params[:advisor]
    @clsyr = params[:class_year]
    if @fn == nil || @fn == ""
      @result = Student.where(lastName: @ln, advisor: @adv, classYear: @clsyr).select("field1, field2, field3, field4")
    elsif @ln == nil|| @ln == ""
      @result = Student.where(firstName: @fn, advisor: @adv, classYear: @clsyr).select("field1, field2, field3, field4")
    elsif @adv == nil || @adv == ""
      @result = Student.where(firstName: @fn, lastName: @ln, classYear: @clsyr).select("field1, field2, field3, field4")
    elsif @clsyr == nil || @clsyr == ""
      @result = Student.where(firstName: @fn, lastName: @ln, advisor: @adv).select("field1, field2, field3, field4")
    elsif @fn == nil || @fn == "" && @ln == nil|| @ln == ""
      @result = Student.where(advisor: @adv, classYear: @clsyr).select("field1, field2, field3, field4")
    elsif @fn == nil || @fn == "" && @adv == nil || @adv == ""
      @result = Student.where(lastName: @ln, classYear: @clsyr).select("field1, field2, field3, field4")
    elsif @fn == nil || @fn == "" && @clsyr == nil || @clsyr == ""
      @result = Student.where(lastName: @ln, advisor: @adv).select("field1, field2, field3, field4")
    elsif @ln == nil|| @ln == "" && @adv == nil || @adv == ""
      @result = Student.where(firstName: @fn, classYear: @clsyr).select("field1, field2, field3, field4")
    elsif @ln == nil|| @ln == "" && @clsyr == nil || @clsyr == ""
      @result = Student.where(firstName: @fn, advisor: @adv).select("field1, field2, field3, field4")
    elsif @adv == nil || @adv == "" && @clsyr == nil || @clsyr == ""
      @result = Student.where(firstName: @fn, lastName: @ln).select("field1, field2, field3, field4")
    elsif @fn == nil || @fn == "" && @ln == nil|| @ln == "" && @adv == nil || @adv == ""
      @result = Student.where(classYear: @clsyr).select("field1, field2, field3, field4")
    elsif @fn == nil || @fn == "" && @ln == nil|| @ln == "" && @clsyr == nil || @clsyr == ""
      @result = Student.where(advisor: @adv).select("field1, field2, field3, field4")
    elsif @ln == nil|| @ln == "" && @adv == nil || @adv == "" && @clsyr == nil || @clsyr == ""
      @result = Student.where(firstName: @fn).select("field1, field2, field3, field4")
    elsif @fn == nil || @fn == "" && @adv == nil || @adv == "" && @clsyr == nil || @clsyr == ""
      @result = Student.where(lastName: @ln).select("field1, field2, field3, field4")
    elsif @fn == nil || @fn == "" && @ln == nil|| @ln == "" && @adv == nil || @adv == "" && @clsyr == nil || @clsyr == ""
      flash[:notice] = "Please fill out the form"
    else 
      @result = Student.where(firstName: @fn, lastName: @ln, advisor: @adv, classYear: @clsyr).select("field1, field2, field3, field4")
    end 
  end
end
