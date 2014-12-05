@root = ZHierarchy.root

@root_doc1 = @root.documents.create!(label: 'ROOT:1', format_identifier: :txt)

@sub = @root.folders.create!(label: 'ROOT:SUB1')
@sub_doc1 = @sub.documents.create!(label: 'SUB1:1', format_identifier: :txt)

@sub2 = @root.folders.create!(label: 'ROOT:SUB2')