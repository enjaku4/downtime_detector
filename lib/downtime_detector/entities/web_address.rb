class WebAddress < Hanami::Entity
  def faulty?
    ['down', 'error'].include?(status)
  end
end
