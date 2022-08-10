#! /bin/bash
docker-compose -f docker-compose.dev.yml up -d
cd client
npm run dev