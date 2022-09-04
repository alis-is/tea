[@view] let get_state (_params, store: unit * storage_type): int =
	store.state

let get_state_off_chain_view(params, store: unit * storage_type): int = get_state(params, store)