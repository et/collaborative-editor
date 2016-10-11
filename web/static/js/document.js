import { Presence } from "phoenix";

let listBy = (user, {metas: metas}) => {
  return {
    user: user,
    onlineAt: metas[0].online_at
  }
};

let Document = {
  currentUser: "Anonymous",
  init(socket, element) {
    if (!element) { return; }

    let documentId = element.getAttribute("data-id");
    let textareaId = element.getAttribute("data-textarea-id")

    let urlParams = new URLSearchParams(window.location.search);

    if (urlParams.has("user")) {
      this.currentUser = urlParams.get("user");
    }
    let currentUser = urlParams.get("user") || "Anonymous";
    let presences = {}

    document.getElementById("user").innerHTML = currentUser

    socket.connect({user: currentUser});
    let documentChannel = socket.channel("documents:" + documentId)

    tinymce.init({
      selector: textareaId,
      setup: (editor) => {
        editor.on('change', () => {
          let payload = { content: editor.getContent() }
          documentChannel.push("document_update", payload)
                         .receive("error", e => console.log(e))
        }),
        editor.on('keyUp', () => {
          let payload = { content: editor.getContent() }
          documentChannel.push("document_update", payload)
                         .receive("error", e => console.log(e))
        })
      }
    });

    documentChannel.on("presence_state", state => {
      presences = Presence.syncState(presences, state)
      this.renderPresences(presences, currentUser)
    })


    documentChannel.on("presence_diff", diff => {
      presences = Presence.syncDiff(presences, diff)
      this.renderPresences(presences, currentUser)
    })

    documentChannel.on("document_update", ({id, content, updated_by}) => {
      if(currentUser !== updated_by) {
        this.renderDocument(content)
      }
    })

    documentChannel.join()
      .receive("ok", _ => console.log("Joined successfully"))
      .receive("error", reason => console.log("join failed", reason))
  },

  renderDocument(content) {
    tinyMCE.activeEditor.setContent(content);
  },

  renderPresences(presences, currentUser) {
    let users = Presence.list(presences, listBy)
      .filter(presence => presence.user !== currentUser)
      .map(presence => presence.user)
    document.getElementById("user_list").innerHTML = users.join(", ")
  }

}

export default Document;
