local M = {}

M.bg_blurred_darker = os.getenv 'USERPROFILE'
  .. '/.config/wezterm/assets/bg-blurred-darker.png'
M.bg_blurred = os.getenv 'USERPROFILE'
  .. '/.config/wezterm/assets/bg-blurred.png'
M.bg_image = M.bg_blurred_darker

return M
