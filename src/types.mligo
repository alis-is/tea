type contract_metadata_type = (string, bytes)big_map

type storage_type = {
	state: int;
	admin: address;
	locked: bool;
	metadata: contract_metadata_type
}

type return_type = operation list * storage_type
