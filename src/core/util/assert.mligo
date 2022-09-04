let assert_admin_or_not_locked (store: storage_type) : unit =
	let sender = Tezos.get_sender() in
	assert_with_error ((not store.locked) || sender = store.admin) "not admin"

let assert_admin (store: storage_type): unit =
	let sender = Tezos.get_sender() in
	assert_with_error (sender = store.admin) "not admin"
