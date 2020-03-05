// FIRST STEP
let courseTitle = document.querySelector('.class-details-header-name').innerHTML;
let video = document.getElementById('vjs_video_3_html5_api').getAttribute('src');
let sessions = Array.from(document.querySelectorAll('.session-item'));
let courseList = [];

for (let i = 1; i < sessions.length; i++) {
  setTimeout(function timer() {
    sessions[i].click();
    setTimeout(function timer() {
      video = document.getElementById('vjs_video_3_html5_api').getAttribute('src');
      let active = document.querySelector('.session-item.active');
      let title = active.querySelector('.session-item-title').innerHTML;
      title = title.replace(/[^A-Z0-9]+/ig, '_');
      courseList.push({
        title: title,
        link: video,
      });
    }, 1000);
  }, i * 3000);
}


// STEP TWO
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



// Old
// // Not Needed as of now...
// // get me of all of the data!
// let course = sessions.map(session => {
//   session.click();
//   let active = document.querySelector('.session-item.active');
//   let title = active.querySelector('.session-item-title').innerHTML;
//   const fullLink = video.getAttribute('src');
//   const link = fullLink.split('?');
//   title = title.replace(/\s+/g, '-');
//   return {
//     title: title,
//     link: link[0],
//   }
// });

// // download function
// function saveText(text, filename) {
//   var a = document.createElement('a');
//   a.setAttribute('href', 'data:text/plain;charset=utf-u,' + encodeURIComponent(text));
//   a.setAttribute('download', filename);
//   a.click()
// }

// // give me that data in a json object!
// course = JSON.stringify(course)
// courseTitle = courseTitle.replace(/\s+/g, '-');
// saveText(course, courseTitle);
