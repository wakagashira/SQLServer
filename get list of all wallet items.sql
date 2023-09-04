select d.id as Uniqueid, u.first_name, u.last_name, dt2.Name, dt2.Type, d.size, d.extension, d.filename, d.id, v.name as vehicle_name, d.content_type, expiry_date, d.Remind_days
from public.v2_documents as d
left outer join public.document_user as du on d.id = du.document_id
left outer join public.document_tag as dt on d.id = dt.document_id
left outer join public.document_tags as dt2 on dt.tag_id = dt2.id and d.business_id = dt2.business_id
left outer join public.v2_users as u on d.driver_id = u.driver_id
Left outer join public.v2_vehicles as v on d.vehicle_id = v.id
where d.business_id = 12381
and dt2.name is not null 