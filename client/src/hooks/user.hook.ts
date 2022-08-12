import { gql, useQuery } from "@apollo/client";

const GET_DOGS = gql`
  query GET_FEATURE{
    feature {
      id
      name
      
    }
  }
`;
