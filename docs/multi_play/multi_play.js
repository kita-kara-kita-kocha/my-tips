var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
let player1, player2;

// Ensure the function is globally accessible
function addPlayer() {
    const videoId1 = document.getElementById('videoId1').value;
    const videoId2 = document.getElementById('videoId2').value;

    if (!videoId1 || !videoId2) {
        alert('ビデオIDを入力してください。');
        return;
    }

    player1 = new YT.Player('player1', {
        height: '390',
        width: '640',
        videoId: videoId1,
    });
    player2 = new YT.Player('player2', {
        height: '390',
        width: '640',
        videoId: videoId2,
    });
}

function playVideo() {
    player1.stopVideo();
    player2.stopVideo();
    player1.playVideo();
    player2.playVideo();
}
