class FileInput < SimpleForm::Inputs::FileInput
  include OcticonsHelper

  def icon(wrapper_options={})
    octicon(wrapper_options[:icon] || 'cloud-upload')
  end
end
