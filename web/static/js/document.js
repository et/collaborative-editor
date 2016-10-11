let Document = {
  init(socket, element) {
    if (!element) { return; }

    let documentId = element.getAttribute("data-id");
    let textareaId = element.getAttribute("data-textarea-id")

    let urlParams = new URLSearchParams(window.location.search);
    let user = urlParams.get("user") || "Anonymous";
    document.getElementById("user").innerHTML = user

    socket.connect({user: user});
    let documentChannel = socket.channel("documents:" + documentId)

    tinymce.init({
      selector: textareaId,
      setup: (editor) => {
        editor.on('keyUp', () => {
          let payload = { content: editor.getContent() }
          documentChannel.push("document_update", payload)
                         .receive("error", e => console.log(e))
        })
      }
    });

    documentChannel.on("document_update", ({id, content, updated_by}) => {
      if(user !== updated_by) {
        this.renderDocument(content)
      }
    })

    documentChannel.join()
      .receive("ok", _ => console.log("Joined successfully"))
      .receive("error", reason => console.log("join failed", reason))
  },

  renderDocument(content) {
    tinyMCE.activeEditor.setContent(content);
  }

}

export default Document;
