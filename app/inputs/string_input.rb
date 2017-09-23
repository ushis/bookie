class StringInput < SimpleForm::Inputs::StringInput

  def input(wrapper_options=nil)
    input_html_classes << 'is-danger' if has_errors?
    super(wrapper_options)
  end
end
