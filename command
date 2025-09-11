cat > mqdashboard.json <<'JSON'
{
  "widgets": [
    {
      "type": "text",
      "x": 0, "y": 0, "width": 24, "height": 2,
      "properties": { "markdown": "# It works" }
    }
  ],
  "start": "-PT3H",
  "periodOverride": "auto"
}
JSON

# Validate JSON
jq . mqdashboard.json

# Upload
aws cloudwatch put-dashboard \
  --dashboard-name Test-Minimal \
  --dashboard-body file://mqdashboard.json
