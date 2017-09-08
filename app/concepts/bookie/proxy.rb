module Bookie
  class Proxy < Disposable::Twin
    feature Default
    feature Sync
    feature Save
    feature Setup::SkipSetter

    delegate :persisted?, :to_key, to: :model
  end
end
