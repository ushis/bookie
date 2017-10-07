class Fixture
  class Document < Fixture

    private

    def random_path
      Pathname.glob(base_path.join('documents', '*')).sample
    end
  end
end
