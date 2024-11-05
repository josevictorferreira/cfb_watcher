export async function sendCommandToVideo(id, command) {
  await new Promise(r => setTimeout(r, 3600));

  var el = document.getElementById(id)

  if (!el) {
    console.error('Element not found')
    return
  }

  var videoContentWindow = el.contentWindow

  videoContentWindow.postMessage(
    '{"event":"command","func":"' + command + '","args":""}',
    "*"
  );
}
