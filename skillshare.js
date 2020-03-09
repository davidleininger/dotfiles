// FIRST STEP
let courseTitle = document.querySelector('.class-details-header-name').innerHTML;
let sessions = Array.from(document.querySelectorAll('.session-item'));
let courseList = [];

async function getVideos () {
  const vidsPromise = courseList.map(async it => {
    const response = await fetch(`https://edge.api.brightcove.com/playback/v1/accounts/3695997568001/videos/${it.id}`, {
      headers: {
        'Accept': 'application/json;pk=BCpkADawqM2OOcM6njnM7hf9EaK6lIFlqiXB0iWjqGWUQjU7R8965xUvIQNqdQbnDTLz0IAO7E6Ir2rIbXJtFdzrGtitoee0n1XXRliD-RH9A-svuvNW9qgo3Bh34HEZjXjG4Nml4iyz3KqF'
      }
    });
    const data = await response.json()
    const url = await data.sources.find(it => it.src.includes('.mp4'))
    it.videoLink = url.src
    return it;
  });
  const vids = await Promise.all(vidsPromise);
  console.log(vids)
  return vids;
}

for (let i = 0; i < sessions.length; i++) {
  setTimeout(function timer() {
    sessions[i].click();
    setTimeout(function timer() {
      const id = document.getElementById('vjs_video_3').getAttribute('data-video-id');
      let active = document.querySelector('.session-item.active');
      let title = active.querySelector('.session-item-title').innerHTML;
      title = `${i + 1}_${title.split('</span>')[1].replace(/[^A-Z0-9]+/ig, '_').slice(1, -1)}`
      console.log(id)
      courseList.push({
        id: id,
        title: title,
      });
    }, 2000);
  }, i * 2500);
}

// STEP TWO
getVideos()

// STEP THREE
// download function
function saveText(text, filename) {
  var a = document.createElement('a');
  a.setAttribute('href', 'data:text/plain;charset=utf-u,' + encodeURIComponent(text));
  a.setAttribute('download', filename);
  a.click()
}

// give me that data in a json object!
courseList = JSON.stringify(courseList)
courseTitle = courseTitle.replace(/[^A-Z0-9]+/ig, '_');
saveText(courseList, courseTitle);
