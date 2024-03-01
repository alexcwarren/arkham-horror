/// @desc	Destroy self


if (!global.is_object_active) {
	instance_destroy(self);
}


event_inherited();