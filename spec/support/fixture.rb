class Fixture
  attr_reader :path

  def initialize
    @path = random_path
  end

  def read
    @read ||= path.read.b
  end

  def open
    path.open
  end

  private

  def random_path
    Pathname.glob(base_path.join('*', '*')).sample
  end

  def base_path
    Rails.root.join('spec', 'fixtures')
  end
end
