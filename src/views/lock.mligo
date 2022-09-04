[@view] let get_lock_state(_params, store: unit * storage_type): bool =
	store.locked

let get_lock_state_off_chain_view(params, store: unit * storage_type): bool = get_lock_state (params, store)