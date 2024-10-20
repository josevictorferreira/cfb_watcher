export function sendCommandToVideo(id, command) {
  var iframeVideo = document.getElementById(id).contentWindow
  iframeVideo.postMessage(
    '{"event":"command","func":"' + command + '","args":""}',
    "*"
  );
}
