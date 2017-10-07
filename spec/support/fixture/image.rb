class Fixture
  class Image < Fixture

    private

    def random_path
      Pathname.glob(base_path.join('images', '*')).sample
    end
  end
end
