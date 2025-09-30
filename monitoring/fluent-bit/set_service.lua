-- service 없으면 compose_service → container_name → "unknown" 순으로 채움
function ensure_labels(tag, timestamp, record)
  local svc = record["service"]
  if svc == nil or svc == "" then
    local cs = record["compose_service"]
    if cs ~= nil and cs ~= "" then
      record["service"] = cs
    else
      local cn = record["container_name"]
      if cn ~= nil and cn ~= "" then
        record["service"] = cn
      else
        record["service"] = "unknown"
      end
    end
  end
  return 1, timestamp, record
end
