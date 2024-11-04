export function sendCommandToVideo(id, command) {
  var iframeVideo = document.getElementById(id).contentWindow
  iframeVideo.postMessage(
    '{"event":"command","func":"' + command + '","args":""}',
    "*"
  );
}

export function focus(id) {
  const element = document.getElementById(id);
  if (element) {
    element.focus();
    element.select();
  }
}
