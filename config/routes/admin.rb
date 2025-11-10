# Below are the routes for madmin
scope path: "/admin", module: :madmin, as: :madmin do
  root to: "dashboard#show"
end
