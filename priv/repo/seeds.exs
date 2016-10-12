# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Editor.Repo.insert!(%Editor.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

 alias Editor.Repo
 alias Editor.Document

 Repo.delete_all Document

Repo.insert! %Document{
  title: "Document 1",
  content: ""
}

Repo.insert! %Document{
  title: "Document 2",
  content: ""
}
