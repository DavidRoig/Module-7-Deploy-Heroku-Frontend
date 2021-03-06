import Axios from 'axios';
import { Member } from './list.api-model';

const urlBase = `${process.env.BASE_API_URL}/members`;
export const getMemberList = async (
  organization: string
): Promise<Member[]> => {
  const { data } = await Axios.get(`${urlBase}/${organization}`, {
    headers: {
      'Access-Control-Allow-Origin': '*',
    },
  });
  return data;
};
