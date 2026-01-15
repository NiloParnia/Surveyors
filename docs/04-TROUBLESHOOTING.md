# Troubleshooting

If Rojo fails to parse default.project.json:
- Ensure keys are "$className" and "$path" (no backslashes like "\$className").
- Prefer ASCII or UTF-8 without BOM.

If Studio will not sync:
- Confirm the Rojo plugin is enabled.
- Confirm the serve port printed by Rojo.
- Visit the localhost URL Rojo prints.
